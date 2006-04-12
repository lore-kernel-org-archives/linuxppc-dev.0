Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id B18EC67C50
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 05:52:31 +1000 (EST)
Received: by nproxy.gmail.com with SMTP id m19so1026467nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 12:52:29 -0700 (PDT)
Message-ID: <528646bc0604121252r48d93ac0ubf7d60116815c1b5@mail.gmail.com>
Date: Wed, 12 Apr 2006 13:52:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Vincent Winstead" <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
In-Reply-To: <20060412193338.75924.qmail@web52010.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc0604121142l115a4fa4r1d9e6bc532300fb7@mail.gmail.com>
	<20060412193338.75924.qmail@web52010.mail.yahoo.com>
Cc: trini@kernel.crashing.org,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Please remember to CC the mailing list when replying

On 4/12/06, Vincent Winstead <vwinstead@yahoo.com> wrote:
>
>    Now, what does that mean, to get the tree.  Does it mean I'll get a li=
st
> of possible kernels that I can download, and then i'll have to choose one=
 of
> them to download?

It means you get a clone of the source tree + revision history which
you can easily keep up to date with mainline.  For things like Paul's
powerpc and powerpc-merge trees, you need to use it because I don't
think anybody is making .tar.gz snapshots from it.

>    Also, how come I have to go through all this 'git' mumbo-jumbo?  Why
> can't I just go to kernel.org and grab one of the 2.6 kernels off of ther=
e,
> then untar it?  What's so special about the source.mvista.com kernels
> through git and rsync?

If you want to use 2.6:  Git is a pretty easy way to keep up to date
with changes other are making on the tree.  But no, you don't have to
use it.  Some of the maintainers have snapshots generated from their
trees which you can download.

If you use 2.4: You need to use rsync to get the linuxppc-2.4 tree
because I don't think anyone is maintaining .tar.gz of the rsync
snapshot.  Email Tom Rini and ask him.  The linuxppc-2.4 tree is
special because it's one of the trees that actually has the ML300
patches integrated.  Mainline does not.

> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> (403) 399-0195
>
>


--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
