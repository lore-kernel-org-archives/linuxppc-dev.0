Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0917FB7CF3
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 03:42:27 +1100 (EST)
In-Reply-To: <ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
Date: Wed, 24 Mar 2010 18:00:18 +0100
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Why the phandle redirection?  Why not just put the firmware blob into
>> a property in the QE node, or as a subnode?
>
> Because there might be multiple QE devices on a single chip, and each
> will need to upload the same firmware.  So instead of embedding the
> firmware multiple times, just embed it once, and have a pointer.

You're messing up the binding because of a (perceived) deficiency in
the DTB format?  Or maybe just the DTS format.  Or maybe you shouldn't
even care about size here.  Or really, the device tree is the wrong
place to store firmware blobs at all.


Segher
