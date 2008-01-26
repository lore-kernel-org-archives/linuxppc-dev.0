Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth03.prod.mesa1.secureserver.net
	(smtpauth03.prod.mesa1.secureserver.net [64.202.165.183])
	by ozlabs.org (Postfix) with SMTP id 491BDDDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Jan 2008 13:44:27 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>
Subject: SET_NETDEV_DEV -> 83xx HDLC Driver??
Date: Fri, 25 Jan 2008 18:43:39 -0800
Message-ID: <000601c85fc5$41e48330$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

I am partly done porting a combination of the 83xx ATM driver and dscc4 HDLC
driver into a 83xx HDLC driver.

However, encounter a call I don't truly understand.

SET_NETDEV_DEV(dev, pointer_to_some_handle);

I can see plenty of examples of this registering some kind of PCI device
handle, however in this case I am not using a PCI device. So what should the
pointer be? Or can this call be ignored, and if so what are the
consequences?

I see the some of the Freescale Ethernet devices don't use this call.

Anyway, can somebody shed some light on if I am going to need this, or a way
to get it to work, without creating a PCI device?

-Russ
