Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id C905FDDF04
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 10:34:18 +1000 (EST)
Received: from [192.168.1.37] (node25.76.251.72.1dial.com [72.251.76.25])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m4Q0WfMG078969
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 17:34:11 -0700 (PDT)
Message-ID: <483A051D.1010108@hypersurf.com>
Date: Sun, 25 May 2008 17:32:29 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: questions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	In idle_6xx.S one finds instructions like:

	lis   r4,powersave_nap@ha
	lwz   r4,powersave_nap@l(r4)

Can someone explain what this is doing? Presumably the first is loading 
an address and the second a value. What do the '@ha' and '@l' do?

	Also, is there any performance difference between:

	lbz rD,d(rA)
	lhz rD,d(rA)
	lwz rD,d(rA)

	While I'm wasting your time, I picked up an ADB infrared wireless 
keyboard. I think it works. But not under Linux. Should it?

	And is there any reason to prefer one over the other for doing byte 
swapping:

	lwbrx rD,rA,rB
	stwbrx rS,rA,rB

kevin
