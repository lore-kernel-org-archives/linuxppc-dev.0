Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 6901C2BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 20:47:03 +1100 (EST)
Message-ID: <41E64204.4000807@ru.mvista.com>
Date: Thu, 13 Jan 2005 12:40:20 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=KOI8-R; format=flowed
Subject: USB host on MPC 8272ADS
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

I am currently trying to support USB host controller on MPC8272ADS board. 
Does anyone proceed with this more or less? In my case, CPM does not 
transmit packet
(READY flag is not cleared as it should when CPM handles transaction).

What can be possible reasons of such behavior?

--
Sincerely, Vitaly
