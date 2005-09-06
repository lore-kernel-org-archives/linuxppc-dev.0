Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 9B6EA680F2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Sep 2005 22:51:58 +1000 (EST)
Message-ID: <431D8F5B.9050803@ru.mvista.com>
Date: Tue, 06 Sep 2005 16:45:15 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20050906133122.225a0922.ajz@cambridgebroadband.com>
In-Reply-To: <20050906133122.225a0922.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCI on MPC827x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex Zeffertt wrote:
> Hi list,
> 
> Does the linuxppc kernel support PCI on PowerQUICC II chips?  If so, in which patch/release was it
> added?
> 
The PCI bridge for 8272ADS has been added in 2.6.12-rc6. This stuff 
should work on PQ2FADS as well.


-- 
Sincerely,
Vitaly
