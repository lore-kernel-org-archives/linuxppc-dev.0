Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 16CBEDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Oct 2008 02:26:12 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KrDgt-0002LF-Hm
	for linuxppc-embedded@ozlabs.org; Sat, 18 Oct 2008 08:26:07 -0700
Message-ID: <20047836.post@talk.nabble.com>
Date: Sat, 18 Oct 2008 08:26:07 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Related to Keypad Driver ....
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ...

If any of you have worked on key pad driver could you please guide me how to
write the same as in the most standard form ...

I have a CPLD from Whre i have to read the key physical status (debouncing
logic in CPLD itself) on interrupt this i have to pass to the application
which ever is using keys for its operation and control ....

The concern is this ...


What could the best way of passing the virtual key status to the application
and how it is done in linux drivers ???? How should i make the API waiting
for Key event and Getting Unblocked ???? Can i make the API as a thread
waiting for signal ??? The same API application could use ... How is it done
in Standard Keyboard Drivers ???

A code snipped or Documentation would really help me ...


I am not sure what way i should proceed ...If any one implemented a Keypad
driver or can suggest your experience 


Thanks in Advance ...

Misbah <><
-- 
View this message in context: http://www.nabble.com/Related-to-Keypad-Driver-....-tp20047836p20047836.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
