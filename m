Return-Path: <pradyumna.sampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 5CCAEDDF6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jun 2007 18:12:33 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1434674pyi
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jun 2007 01:12:30 -0700 (PDT)
Message-ID: <f87351060706290112o407f75e5h9dffd9939ab80ef9@mail.gmail.com>
Date: Fri, 29 Jun 2007 13:42:29 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: "Nicholas Hickman" <nhickman@dtechlabs.com>
Subject: Re: mpc8270 & Intel 82551ER on 2.6.17.14
In-Reply-To: <8140AAF341CC904BA92C3D6A5A1909782A2FA3@ditech-1.ditechllc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <8140AAF341CC904BA92C3D6A5A1909782A2FA3@ditech-1.ditechllc.com>
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

Hi Nicholas,

On 6/29/07, Nicholas Hickman <nhickman@dtechlabs.com> wrote:
>
>
> I am having trouble getting two 82551ER Ethernet controllers running in
> Linux.  I am able to scan the PCI bus and see the devices and I was even
> able to program the EEPROM from U-boot.
>
> In the kernel I mapped the IRQ's through /arch/ppc/m82xx_pci.c.  I've been
> using the e100 drive that comes with the 2.6.17.14 kernel and have also
> tried the driver directly from Intel.  Both give the same results.  The PCI
> scan shows the correct output for how the device should be configured.
<snip..>

I have the same, exact same problem. But there are some of the
differences with the setup though. I have an MPC5200B and the other
difference is that I have a 2.6.21-rt3. However its the same ethernet
controller.

I am trying out a few things here, some of them being complete
guesses. But if I hit something, I will let this list know. Anyone
else had similar issues ? Request you to please holler.

regards
prady
-- 
htp://prady.livejournal.com
