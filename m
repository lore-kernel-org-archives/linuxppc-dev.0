Return-Path: <tehn.yit.chin@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 52068DDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 11:06:35 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so726004wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Mar 2008 17:06:34 -0700 (PDT)
Message-ID: <bf04f99c0803191706q7e3a43a3i50a1d479650a3f9d@mail.gmail.com>
Date: Thu, 20 Mar 2008 11:06:34 +1100
From: "Tehn Yit Chin" <tehn.yit.chin@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: interrupt handlers PowerPC via GCC
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Apologies for such a basic question. I am trying to write an ISR on a
MPC551x. When I tried to use the interrupt attribute with
powerpc-eabi-gcc such as

_attribute_((interrupt_handler)) foobarISR(void)
{
}


it complains of a syntax error. Upon further investigation in the GCC,
it appears that the interrupt attribute is not supported by
powerpc-eabi-gcc.

Am I missing something fundamental here? How are the current interrupt
service routines created at the moment?

Any pointers would be appreciated.

tyc
