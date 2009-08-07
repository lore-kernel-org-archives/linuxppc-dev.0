Return-Path: <ljaenicke@innominate.com>
Received: from home.innominate.com (home.innominate.com [77.245.32.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1A705B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 17:48:09 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by home.innominate.com (Postfix) with ESMTP id 0ED40232BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 09:48:02 +0200 (CEST)
Received: from home.innominate.com ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 0yifutb8SOhs for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 09:48:01 +0200 (CEST)
Received: from lutz.bln.innominate.local (lutz.bln.innominate.local
	[10.1.0.160])
	by home.innominate.com (Postfix) with ESMTP id DA18823143
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 09:48:01 +0200 (CEST)
Date: Fri, 7 Aug 2009 09:48:01 +0200
From: Lutz Jaenicke <ljaenicke@innominate.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC8313 performance evaluation
Message-ID: <20090807074801.GA19763@lutz.bln.innominate.local>
References: <20090806180035.GA19088@lutz.bln.innominate.local>
	<8731B515-14B1-4580-A196-75E57543C3F9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8731B515-14B1-4580-A196-75E57543C3F9@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2009 at 02:16:55PM -0500, Kumar Gala wrote:
>
> On Aug 6, 2009, at 1:00 PM, Lutz Jaenicke wrote:
>> With the MPC8343@400MHz I get a throughput of approx. 24500 frames/s
>> using the predefined firewall rules.

>> With the MPC8313 I get a significantly lower value:
>> MPC8313@250MHz          12500fps
>> MPC8313@333MHz          14500fps
>> MPC8313@416MHz          15500fps      (333MHz type, overclocked)

> What DDR frequencies (and width) are you running the 8343 vs 8313 at.   
> This can have a significant impact on performance.

The 8343 is running DDR2 32bit at 266MHz (CSB 266MHz)
The 8313 is running DDR2 32bit at 333MHz (CSB 166MHz)

The test were performed with 128byte frames so that the overall
bandwidth needed is far below even 100Mbit/s.

Best regards,
	Lutz
-- 
Dr.-Ing. Lutz Jänicke
CTO
Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.921028-200
fax: +49.30.921028-020
Rudower Chaussee 13
D-12489 Berlin, Germany
www.innominate.com

Register Court: AG Charlottenburg, HR B 81603
Management Board: Dirk Seewald
Chairman of the Supervisory Board: Volker Bibelhausen
