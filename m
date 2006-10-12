Return-Path: <gun_raj@yahoo.com>
Received: from web52403.mail.yahoo.com (web52403.mail.yahoo.com
	[206.190.48.166]) by ozlabs.org (Postfix) with SMTP id 0C49F67B6C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 15:06:24 +1000 (EST)
Message-ID: <20061012045943.9389.qmail@web52403.mail.yahoo.com>
Date: Wed, 11 Oct 2006 21:59:43 -0700 (PDT)
From: ganesh subramonian <gun_raj@yahoo.com>
Subject: Handling machine check exception
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to modify the machinecheck exception
handler so that checks caused by data access to a
particular address range can be ignored. In mpc866
there is a register called DAR(Data Address Register)
which gives the address[access to] which caused the
exception. However this is not mentioned in the
MPC8247 manual. Is there some equivalent register for
8247. (It seemed to me that the DAR should be a core
register and hence should be there on 8247 also. but
if i try to read i really dont get the address causing
the error).

Or is there some way i can specify that access to a
particular range of address should not cause a machine
check?? Please help.

thanks
ganesh

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
