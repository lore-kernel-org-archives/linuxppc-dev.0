Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep24-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 12C21DE39D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 05:08:49 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
Date: Thu, 2 Oct 2008 21:08:44 +0200
References: <200810011947.16543.niklaus.giger@member.fsf.org>
	<200810020712.15088.niklaus.giger@member.fsf.org>
	<20081002064156.GS25598@yookeroo.seuss>
In-Reply-To: <20081002064156.GS25598@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810022108.44690.niklaus.giger@member.fsf.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag 02 Oktober 2008 08.41:56 schrieb David Gibson:
> On Thu, Oct 02, 2008 at 07:12:14AM +0200, Niklaus Giger wrote:
> > Hi David
> >
> > Am Donnerstag 02 Oktober 2008 02.52:08 schrieb David Gibson:
> > > That will work, but will lose comments, references, and other
> > > formatting, because it essentially compiles then decompiles the tree.
> > > You probably don't want to do that. =A0There's also an explicit
> > > conversion program, convert-dtsv0, which will preserve that
> > > not-significant-to-output, but useful for the reader information.
> >
> > Thanks for providing me the hint. Using it, would surely  have been
> > easier than adding manually the comment again. However I using the sear=
ch
> > "dtc dts-v1 syntax conversion script" didn't give me any hint and even =
in
> > the the current  http://www.jdl.com/software/dtc.git I find no word in
> > the Documentation about convert-dtsv0.
> >
> > Neither does it get installed when calling make install.
>
> Ah, yes, that's a bug.
>
> > Therefore I would suggest you to add a small remark like this:
> >
> > convert-dtsv0 is a small utility program which converts (DTS)
> > Device Tree Source from the obsolete version 0 to version 1. Version 1
> > DTS files are marked by line "/dts-v1/;" at the top of the file.
>
> Add this remark where, though?
Add a small chapter IV Utilities in your Documentation/manual.txt.

And if the http://www.jdl.com/git_repos/ would work again, I think the spid=
ers=20
would pick it up from there.

Best regards

Niklaus
