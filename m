Return-Path: <praveen.mehrotra@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.203])
	by ozlabs.org (Postfix) with ESMTP id 2784D2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 13:15:41 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id y7so237663rne
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 Nov 2004 18:15:39 -0800 (PST)
Message-ID: <a2ea557e041103180817107b9e@mail.gmail.com>
Date: Wed, 3 Nov 2004 18:08:59 -0800
From: Praveen Mehrotra <praveen.mehrotra@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Critical Interrupt on 405EP
Reply-To: Praveen Mehrotra <praveen.mehrotra@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm running 2.4.20 kernel on a 405EP board and am interested in using
critical interrupt for one of the devices. I've almost got it working,
except that after several minutes (ranging from 10-30) of operation 
kernel crash occurs.

Has anyone got the critical interrupt on 405EP working for 2.4.x
kernels ? I can post details specific to changes I made if someone has
experience regarding this.

Thanks,
Praveen
