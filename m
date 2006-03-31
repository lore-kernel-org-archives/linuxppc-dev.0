Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 0BA35679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Apr 2006 05:27:25 +1100 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by mail.skekraft.net (Postfix) with ESMTP id 5C488A401B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 20:27:23 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200b and floating point
Date: Fri, 31 Mar 2006 20:27:22 +0200
References: <20060331133619.GD7738@localhost.localdomain>
In-Reply-To: <20060331133619.GD7738@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603312027.22359.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On fredag 31 mars 2006 15.36, Sascha Hauer wrote:
> Hi,
>
> I'm working with a mpc5200b custom board and I'm trying to run an
> application with floating point. All floating point variables seem to
> zero all the time. Since I'm not very familiar with powerpc it might be
> something stupid I have overlooked.

Since a lot of PowerPC do not have floating point processor your tools
might be setup to compile without it (compare with sse2 on x86).

Check your compiler flags again.
Define -mcpu= and -mhard-float
Undefine -msoft-float

/RogerL
