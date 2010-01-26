Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B550B7EBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 09:18:15 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0QMIBJq019422 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 15:18:11 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o0QMP0wg018647
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 16:25:00 -0600 (CST)
Message-ID: <4B5F6A11.70409@freescale.com>
Date: Tue, 26 Jan 2010 16:17:53 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan.Geer@faa.gov
Subject: Re: BSE-IP
References: <OF54D7A55A.FE6F4A1D-ON852576B7.00781D7D-852576B7.00794B17@faa.gov>
In-Reply-To: <OF54D7A55A.FE6F4A1D-ON852576B7.00781D7D-852576B7.00794B17@faa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan.Geer@faa.gov wrote:
> Any idea of the last kernel version that worked?  So I know I can count on
> that as a reference?  

I'm not familiar with the board, sorry -- was just pointing out that 
there shouldn't be anything too dependent on the particular boards/chips 
  that are currently supported out-of-the-box, and it should be easier 
to add a new board than it used to be.

> I have the 2.2 pre7 from BSE, but there have been a few changes since. ;^)

Hopefully not changes in the board. :-)

That kernel should still work for extracting any knowledge about the 
board's hardware that may or may not be clear from its documentation.

> It appears the image (bootwrapper) needs to be completely self-contained,
> and needs to understand how to read the flash parameters.  That's on my
> list.

What firmware is on the board?

-Scott
