Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67A59B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 19:02:40 +1000 (EST)
Subject: Re: Introduce support for little endian PowerPC
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Date: Fri, 1 Oct 2010 04:02:24 -0500
Message-Id: <2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 1, 2010, at 2:05 AM, Ian Munsie wrote:

> Some PowerPC processors can be run in either big or little endian =
modes, some
> others can map selected pages of memory as little endian, which allows =
the same
> thing. Until now we have only supported the default big endian mode in =
Linux.
> This patch set introduces little endian support for the 44x family of =
PowerPC
> processors.

=46rom a community aspect is anyone actually going to use this?  Is this =
going to be the equivalent of voyager on x86?  I've got nothing against =
some of the endian clean ups this introduces.  However the changes to =
misc_32.S are a bit ugly from a readability point of view.  Just seems =
like this is likely to bit-rot pretty quickly.

- k
