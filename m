Return-Path: <aubrey1127@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id CE8A22BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 19:50:30 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 36so679713wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 00:50:27 -0800 (PST)
Message-ID: <7f834d4e0501130050666b757a@mail.gmail.com>
Date: Thu, 13 Jan 2005 16:50:27 +0800
From: Aubrey Lee <aubrey1127@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: About Zebra Error
Reply-To: Aubrey Lee <aubrey1127@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 hi, In the PC(i686) system, I build and run zebra successfully. And now
I'm porting it to the powerpc system. Cross-compiling finished without error.
But when I run the zebra from my target board, it gives me  a big headache:
--------------------------------------------------------------------------  
bash-2.05b# /opt/zebra/sbin/zebra
             sock: Address family not supported by protocol
----------------------------------------------------------------------------
And Up to now I cann't find the message in the souce 
code files.  
     The two ethx and their driver of my board is OK.
     What shall I do?
     Any comment and suggestion will be welcome!
     Thank you very much!
      Best regards!
          Aubrey.Lee
