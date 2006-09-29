Return-Path: <enorm@126.com>
Received: from m15-112.126.com (m15-112.126.com [220.181.15.112])
	by ozlabs.org (Postfix) with SMTP id 6826667B93
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 11:25:09 +1000 (EST)
Message-ID: <00a901c6e366$1d3e4f70$a309a8c0@enorm>
From: "enorm" <enorm@126.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: About cache
Date: Fri, 29 Sep 2006 09:25:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I found in mpc85xx start.s, before doing any initialization it disabled 
 i-cache & d-cache. Must we do so? If we don't disable them what will it 
 cause? 

Best Regards
Enorm
