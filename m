Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id 8E4A1DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Oct 2007 13:24:21 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so958340rvf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Oct 2007 20:24:20 -0700 (PDT)
Message-ID: <fa686aa40710212024h2e400b93sacbbc5bbf15a8a35@mail.gmail.com>
Date: Sun, 21 Oct 2007 21:24:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Hahn" <jhahn@bcfsemi.com>
Subject: Re: SystemACE driver problem
In-Reply-To: <001a01c81456$985b6a90$c9123fb0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <13290652.post@talk.nabble.com>
	<fa686aa40710190704j18feabf2geb417d554ebb11c@mail.gmail.com>
	<13300089.post@talk.nabble.com>
	<fa686aa40710191120w209b62a0l4f71e528e5f1a1b3@mail.gmail.com>
	<001a01c81456$985b6a90$c9123fb0$@com>
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

On 10/21/07, John Hahn <jhahn@bcfsemi.com> wrote:
> Grant
>
> Regarding your comment about the new xsysace.c driver vs. the old Xilinx
> one, is that chosen at the kernel config time ?
>
> i.e.
> cp arch/ppc/configs/ml403_defconfig
> make ARCH=ppc CROSS_COMPILE=/opt/eldk4.1/usr/bin/ppc_4xx- oldconfig
>
> ...
> Xilinx SystemACE support (XILINX_SYSACE) [N/m/y/?] (NEW) y
> Xilinx SystemACE support (old driver) (XILINX_SYSACE_OLD) [N/m/y/?] (NEW) N
>
> I am also about build and test with the 2.6.23-rc2 same source. Just wanted
> to be sure I am choosing the right driver for the ml403 reference design
> bits from Xilinx.

Both drivers work.  The new driver is faster, but the old driver is
more featurefull.  If one isn't working for you, try the other and
report your experiences with both here to the list.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
