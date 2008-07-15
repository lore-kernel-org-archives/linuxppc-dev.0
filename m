Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AAB57DE6AE
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 03:29:47 +1000 (EST)
Message-Id: <9340606A-7A87-4475-A133-81F5B59C7960@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080715161053.GA9356@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: add FHCI USB, FSL MCU,
	FSL UPM and GPIO LEDs bindings
Date: Tue, 15 Jul 2008 11:23:42 -0500
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
	<EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
	<20080703182440.GA2576@polina.dev.rtsoft.ru>
	<8A8D87F8-A1DD-467D-8D83-CDC651B99F45@kernel.crashing.org>
	<20080704165328.GA9962@polina.dev.rtsoft.ru>
	<C3A1E950-3D5F-4172-90B6-1566D4A70B7C@kernel.crashing.org>
	<20080715161053.GA9356@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>
> Ugh, you fixed bindings' directory in Jochen's CPM patch, but not in
> my patch:
>
> commit 91993d56812fd09b6cccea12d3c83df623cb0ea6
> Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date:   Fri Jul 4 20:53:28 2008 +0400
>
>    powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs bindings
>
>    This patch adds few bindings for the new drivers to be submitted  
> through
>    the appropriate maintainers.
>
>    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> diff --git a/Documentation/powerpc/device-tree/fsl/mcu- 
> mpc8349emitx.txt b/Documentation/powerpc/device-tree/fsl/mcu- 
> mpc8349emit
> new file mode 100644
> index 0000000..0f76633
> --- /dev/null
> +++ b/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt
> ....

Rebased the tree and fixed it.  Can you look over the files and make  
sure everything looks ok.  (I'm partially concerned about the QE usb  
node).

- k
