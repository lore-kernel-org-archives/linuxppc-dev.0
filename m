Return-Path: <mensch0815@googlemail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id E2CBDDDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Nov 2008 00:49:53 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2955571rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 05:49:52 -0800 (PST)
Message-ID: <3e4778d50811250549u2641e457q75d7a56b42c3081@mail.gmail.com>
Date: Tue, 25 Nov 2008 14:49:51 +0100
From: matthias <mensch0815@googlemail.com>
To: linuxppc-embedded@ozlabs.org
Subject: get opb answer in device driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm working on a virtex2pro with a ppc405 core.
I'm implementing a peripheral device and the corresponding device
driver. As I get a rare behaviour on my device I would like to get the
answer from it to a read/write request.

Is there any possibility to get the the answer of an opb-device
(wether it is error or retry) inside a device driver to handle it?

best regards,
Matthias
