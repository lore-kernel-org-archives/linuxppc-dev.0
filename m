Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id CD125DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 17:06:48 +1000 (EST)
Received: from [192.168.1.37] (node34.74.251.72.1dial.com [72.251.74.34])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m3Q76P3U031290
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 00:06:44 -0700 (PDT)
Message-ID: <4812DFA3.6090106@hypersurf.com>
Date: Sat, 26 Apr 2008 00:54:11 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: get_cycles()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

H,

	Anyone know how to turn get_cycles() into an actual time in a module? 
ppc_tb_freq does not seem to be exported?

kevin
