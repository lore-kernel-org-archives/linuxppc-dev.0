Return-Path: <prakash.org@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 5E7E667CED
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 16:05:22 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so323850nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 07 Nov 2006 21:05:20 -0800 (PST)
Message-ID: <348caa310611072105t5b0fbc73r19d7561f49945c56@mail.gmail.com>
Date: Wed, 8 Nov 2006 10:35:20 +0530
From: "Prakash Ramaraju" <prakash.org@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Clock Modification of MPC885 for USB Host Functionality
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings

Currently I have a MPC885 based board running at 50MHz. I want USB host
working at full speed with internal clock. Assuming I need to change the
General System Clock Frequency (GCLK2) to 48MHz, I got this calculation with
input frequency of 10MHz from an u-boot script.

pdf mfi mfn mfd s dbrmo     dpref    dpgdck     jdbck     gclk2 exact?
--- --- --- --- - -----     -----    ------     -----     ----- ------
  0   9   3   4 1     0  10000000 192000000  96000000  48000000    YES
  0   9   6   9 1     0  10000000 192000000  96000000  48000000    YES
  0   9   9  14 1     0  10000000 192000000  96000000  48000000    YES
  0   9  12  19 1     0  10000000 192000000  96000000  48000000    YES

I modified CFG_PLPRCR (to 19194000) in u-boot config file to match this. But
I'm getting only 45MHz output clock (not exactly 48MHz which is needed for
USB to work)

If anyone can shed some info making the USB work on MPC885 with internal
clock or changing the clock freq to exact 48MHz, it will be helpful.

Thanks

-- 
With best regards,
Prakash
