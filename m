Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id EF7C9DDD09
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Aug 2007 00:10:05 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so1654928wag
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 07:10:04 -0700 (PDT)
Message-ID: <fa686aa40708250710q72bdaa90na4974f1af6030997@mail.gmail.com>
Date: Sat, 25 Aug 2007 08:10:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Ming Liu" <eemingliu@hotmail.com>
Subject: Re: how to get your linux-2.6-virtex tree?
In-Reply-To: <BAY138-F375ED55654A9E20AE05486B2D00@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708241121s359fbaf2r7adb8886a2d3ff65@mail.gmail.com>
	<BAY138-F375ED55654A9E20AE05486B2D00@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/25/07, Ming Liu <eemingliu@hotmail.com> wrote:
> Dear Grant,
> I am trying to get your linux-2.6-virtex tree. When I release the command
> "git-clone git://git.secretlab.ca/git/linux-2.6-virtex.git", it shows
>
> fatal: unexpected EOF
> fetch-pack from 'git://git.secretlab.ca/git/linux-2.6-virtex.git' failed.

Hmmm....  Works fine from my machines.

What does 'dig git.secretlab.ca' tell you?  I see this:
;; ANSWER SECTION:
git.secretlab.ca.       1320    IN      A       208.123.74.12

Have you tried the git:// protocol?

This is what I get when I clone from another machine:

grant@trillian:~/temp$ git-clone
git://git.secretlab.ca/git/linux-2.6-virtex.git
Initialized empty Git repository in /home/grant/temp/linux-2.6-virtex/.git/
remote: Generating pack...
remote: Counting objects: 504459
remote: Done counting 548333 objects.
remote: Deltifying 548333 objects...
remote:  100% (548333/548333) done
Indexing 548333 objects...
remote: Total 548333 (delta 445331), reused 547457 (delta 444455)
 100% (548333/548333) done
Resolving 445331 deltas...
 100% (445331/445331) done
Checking 22546 files out...
 100% (22546/22546) done
grant@trillian:~/temp$

---
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
