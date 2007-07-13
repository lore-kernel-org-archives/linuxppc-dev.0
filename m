Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by ozlabs.org (Postfix) with ESMTP id C2D18DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jul 2007 03:36:09 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so502046nzf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 10:36:09 -0700 (PDT)
Message-ID: <fa686aa40707131036k1bc5f2c4t701a44e0ef25acc8@mail.gmail.com>
Date: Fri, 13 Jul 2007 11:36:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
Subject: Re: [PATCH] Xilinx SystemACE device driver
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17210@hsv1dafpew02.das.gov.sanm.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070712225138.13213.38257.stgit@trillian>
	<939D37AEB47F1F49B88FAB6599B6023501A1720B@hsv1dafpew02.das.gov.sanm.corp>
	<fa686aa40707130841w6a36146cufc85a62f78a53b0d@mail.gmail.com>
	<939D37AEB47F1F49B88FAB6599B6023501A17210@hsv1dafpew02.das.gov.sanm.corp>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/13/07, Robertson, Joseph M. <joseph.robertson@sanmina-sci.com> wrote:
>
> Hi,
>
>  Ok, so outlook is a problem.  The horror is that, where I work thats all I
> can use.  They block all the outside systems like gmail, yahoo, etc.  So
> under linux, I have to use the web access for outlook.  ugh.
>  Why I work here I don't know, they think all software HAS to be bought.
>
>  Um, so your patch creates another xsysace.c file, all by itself, which is a
> NEW driver?
>  This replaces the 8 files of the previous driver?  What happens to all the
> low level funcs?
>
>  Where can I get your 2.6.22 tree to see how this is all supposed to go
> together?  Is there a tar.bz2 package?

Start with installing 'git'.  http://git.or.cz/

Then clone Linus' tree:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

if you're company blocks the git port, then you can use HTTP instead:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

There are a number of different git repos out there with virtex
support integrated, but I'm going to use the example of my tree...  (I
rebased my tree onto 2.6.22, so it's very up to date)

$ git fetch git://git.secretlab.ca/git/linux-2.6.git virtex-dev:virtex-dev
(Again, you can use http:// if the git port is blocked)

Now you'll have a branch in your git tree called 'virtex-dev' that
includes my patchset.

You can checkout that branch with:
$ git branch mybranch virtex-dev
$ git checkout mybranch

You can view the patchset with:
$ gitk virtex-dev

You can look at in individual patch with:
$ git show <SHA1 id>
(All git commits are identified with a SHA1 hash; you'll see them in
gitk, or when you do a 'git log)

Also, you can view the tree online at:
http://git.secretlab.ca/cgi-bin/gitweb.cgi?p=linux-2.6.git;a=summary

If you click on the 'commitdiff' link for a patch, followed by
'plain', you should get a downloadable version of the patch.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
