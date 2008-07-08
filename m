Return-Path: <paolo.doz@gmail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.230])
	by ozlabs.org (Postfix) with ESMTP id 6F00DDDEE0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 17:55:09 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 34so7657229hue.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jul 2008 00:55:07 -0700 (PDT)
Message-ID: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
Date: Tue, 8 Jul 2008 09:55:06 +0200
From: "Paolo Doz" <paolo.doz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: While(1) in kernel space
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_25956_31746814.1215503706756"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_25956_31746814.1215503706756
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi folks,
I'm developing a custom SPI driver (char device) on a MPC5200b, the
microcontroller linked as slave implements a protocol that must follow
strict timing constraints. I need to receive and send messages every 6msec.
Actually there is a user space program that synchronizes the two units, but
I would prefer to eliminate it and move the relative code into the kernel
space. Is it possible to have a non returning function, with a sort of
while(1) inside?

Thanks for the help

Paolo

------=_Part_25956_31746814.1215503706756
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi folks,<br>I&#39;m developing a custom SPI driver (char device) on a MPC5200b, the microcontroller linked as slave implements a protocol that must follow strict timing constraints. I need to receive and send messages every 6msec. Actually there is a user space program that synchronizes the two units, but I would prefer to eliminate it and move the relative code into the kernel space. Is it possible to have a non returning function, with a sort of while(1) inside?<br>
<br>Thanks for the help<br><br>Paolo<br>

------=_Part_25956_31746814.1215503706756--
