Return-Path: <enorm@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
	by ozlabs.org (Postfix) with SMTP id 155BD67BEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 21:11:09 +1000 (EST)
Message-ID: <001401c6dd6e$a01d65a0$a309a8c0@enorm>
From: "enorm" <enorm@126.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: A question about power on
Date: Thu, 21 Sep 2006 19:11:01 +0800
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

After power on, cpu reads instruction from certain addr. But how does it 
know how many bits he can read at once. 
