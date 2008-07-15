Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 36115DF458
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:10:55 +1000 (EST)
Date: Tue, 15 Jul 2008 20:10:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO
	LEDs bindings
Message-ID: <20080715161053.GA9356@polina.dev.rtsoft.ru>
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
	<EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
	<20080703182440.GA2576@polina.dev.rtsoft.ru>
	<8A8D87F8-A1DD-467D-8D83-CDC651B99F45@kernel.crashing.org>
	<20080704165328.GA9962@polina.dev.rtsoft.ru>
	<C3A1E950-3D5F-4172-90B6-1566D4A70B7C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <C3A1E950-3D5F-4172-90B6-1566D4A70B7C@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 08:21:38AM -0500, Kumar Gala wrote:
>
> On Jul 4, 2008, at 11:53 AM, Anton Vorontsov wrote:
>
>> This patch adds few bindings for the new drivers to be submitted  
>> through
>> the appropriate maintainers.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>
>> Updated to decrypt MCU, and to split the bindings into appropriate  
>> files.
>>
>> .../powerpc/device-tree/fsl/mcu-mpc8349emitx.txt   |   17 +++++++++
>> Documentation/powerpc/device-tree/fsl/qe/usb.txt   |   37 +++++++++++ 
>> +++++++++
>> Documentation/powerpc/device-tree/fsl/upm-nand.txt |   28 +++++++++++ 
>> ++++
>> Documentation/powerpc/device-tree/gpio/led.txt     |   15 ++++++++
>> 4 files changed, 97 insertions(+), 0 deletions(-)
>> create mode 100644 Documentation/powerpc/device-tree/fsl/mcu- 
>> mpc8349emitx.txt
>> create mode 100644 Documentation/powerpc/device-tree/fsl/qe/usb.txt
>> create mode 100644 Documentation/powerpc/device-tree/fsl/upm-nand.txt
>> create mode 100644 Documentation/powerpc/device-tree/gpio/led.txt
>
> applied.

Ugh, you fixed bindings' directory in Jochen's CPM patch, but not in
my patch:

commit 91993d56812fd09b6cccea12d3c83df623cb0ea6
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Fri Jul 4 20:53:28 2008 +0400

    powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs bindings
    
    This patch adds few bindings for the new drivers to be submitted through
    the appropriate maintainers.
    
    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt b/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emit
new file mode 100644
index 0000000..0f76633
--- /dev/null
+++ b/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt
....

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
