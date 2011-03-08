Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1F655B6EDF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2011 05:53:11 +1100 (EST)
Date: Tue, 8 Mar 2011 12:52:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: Vasanth Ragavendran <ragavendrapec@yahoo.co.in>
Subject: Re: Mpc8315erdb openvpn segmentation fault
Message-ID: <20110308125259.73d3094b@schlenkerla>
In-Reply-To: <31094242.post@talk.nabble.com>
References: <31086738.post@talk.nabble.com>
	<20110307142207.6e879798@schlenkerla>
	<31094242.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 7 Mar 2011 20:28:32 -0800
Vasanth Ragavendran <ragavendrapec@yahoo.co.in> wrote:

> 
> Thanks a ton Scott. Actually i was working with the same version of the
> kernel on both the boards.
> it was 2.6.29.6. neither i changed the u-boot. it was the same in both.
> however i recompiled the kernel and i installed on both the boards and it
> worked fine! :) thanks again for responding. however i've another question.
> my filesystem in the board is non-persistent i.e. the files i create are
> erased after i reboot i know the files are getting stored in RAM and i wish
> to make them persistent. what do i need to do for this? should i create a
> separate partition in the flash and load certain files into that partition?
> or how should i make it persistent so that files stay beyond reboot! thanks
> again! eagerly awaiting your response.

Yes, you should create a filesystem (e.g. jffs2) on a flash partition.

-Scott
