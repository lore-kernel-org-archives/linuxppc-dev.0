Return-Path: <mederle_nicolas@yahoo.fr>
Received: from smtp007.mail.ukl.yahoo.com (smtp007.mail.ukl.yahoo.com
	[217.12.11.96]) by ozlabs.org (Postfix) with SMTP id 549ACDDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 16:36:17 +1000 (EST)
Message-ID: <46A9925A.2060508@yahoo.fr>
Date: Fri, 27 Jul 2007 08:36:10 +0200
From: Nicolas Mederle <mederle_nicolas@yahoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org,  linuxppc-embedded@ozlabs.org
Subject: Decermenter overflow interrupt atfer the init.d launch.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

       I want to know how the kernel switch the task. Because my kernel 
start very well, and it launch  the init.d. With the log, i can see that 
the kernel launch the getty task. But after, there is a decrementer 
overflow interrupt  ( vector at adress 900 ). Is it the task switch? Or 
is it an error in the decrementer init.

-- 

Cordialement,

MEDERLE Nicolas.
