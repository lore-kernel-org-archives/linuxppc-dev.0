Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82BBBDEAC9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:21:45 +1000 (EST)
Message-Id: <C3A1E950-3D5F-4172-90B6-1566D4A70B7C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080704165328.GA9962@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: add FHCI USB, FSL MCU,
	FSL UPM and GPIO LEDs bindings
Date: Tue, 15 Jul 2008 08:21:38 -0500
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
	<EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
	<20080703182440.GA2576@polina.dev.rtsoft.ru>
	<8A8D87F8-A1DD-467D-8D83-CDC651B99F45@kernel.crashing.org>
	<20080704165328.GA9962@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 4, 2008, at 11:53 AM, Anton Vorontsov wrote:

> This patch adds few bindings for the new drivers to be submitted  
> through
> the appropriate maintainers.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Updated to decrypt MCU, and to split the bindings into appropriate  
> files.
>
> .../powerpc/device-tree/fsl/mcu-mpc8349emitx.txt   |   17 +++++++++
> Documentation/powerpc/device-tree/fsl/qe/usb.txt   |   37 +++++++++++ 
> +++++++++
> Documentation/powerpc/device-tree/fsl/upm-nand.txt |   28 +++++++++++ 
> ++++
> Documentation/powerpc/device-tree/gpio/led.txt     |   15 ++++++++
> 4 files changed, 97 insertions(+), 0 deletions(-)
> create mode 100644 Documentation/powerpc/device-tree/fsl/mcu- 
> mpc8349emitx.txt
> create mode 100644 Documentation/powerpc/device-tree/fsl/qe/usb.txt
> create mode 100644 Documentation/powerpc/device-tree/fsl/upm-nand.txt
> create mode 100644 Documentation/powerpc/device-tree/gpio/led.txt

applied.

- k
