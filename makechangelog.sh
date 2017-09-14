#!/bin/bash
echo > ../iotaledger-iri-ci/debian/changelog
prevtag=v1.2.0 
git tag -l v* | sort -V | while read tag; do     (echo "$pkgname (${tag#v}) unstable; urgency=low"; git log --pretty=format:'  * %s' $prevtag..$tag; git log --pretty='format:%n%n -- %aN <%aE>  %aD%n%n' $tag^..$tag) | cat - ../iotaledger-iri-ci/debian/changelog | sponge ../iotaledger-iri-ci/debian/changelog;         prevtag=$tag; done
