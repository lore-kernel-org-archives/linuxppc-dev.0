Return-Path: <spoorthi.ka@globaledgesoft.com>
Received: from gesmail.globaledgesoft.com (gesmail.globaledgesoft.com
	[203.76.137.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92CCFDE35D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 May 2008 00:41:14 +1000 (EST)
Received: from [172.16.8.111] (spoorthi_ka.globaledgesoft.com [172.16.8.111])
	by gesmail.globaledgesoft.com (Postfix) with ESMTP id 6A4FC17B426
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 May 2008 20:04:44 +0530 (IST)
Message-ID: <48401111.1060703@globaledgesoft.com>
Date: Fri, 30 May 2008 20:07:05 +0530
From: Spoorthi KA <spoorthi.ka@globaledgesoft.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Timer task synchronization
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

    I am dealing with timer synchronization problem.. we have two timer 
threads. The two timers are started one after the other. The first timer 
timeout value is 10s and the second timer tiemout value is 15s.

The first timer fires after 10s and the timer thread is suspended until 
the second timer completes its task. once the second timer is done the 
first timer resumes.

sometimes the first timer resumes back even before the second timer 
starts and blocks the second timer thread..

can anybody plz help me with this...


spoorthi
