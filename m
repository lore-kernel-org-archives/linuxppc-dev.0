Return-Path: <melinda.develey70@yahoo.com>
Received: from web63904.mail.re1.yahoo.com (web63904.mail.re1.yahoo.com
	[69.147.97.119]) by ozlabs.org (Postfix) with SMTP id 2E14FDDD07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 07:32:57 +1000 (EST)
Date: Wed, 29 Aug 2007 14:26:15 -0700 (PDT)
From: melinda develey <melinda.develey70@yahoo.com>
Subject: spin_lock doesn't work?!?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1374990440-1188422775=:15506"
Message-ID: <177333.15506.qm@web63904.mail.re1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1374990440-1188422775=:15506
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I discovered that I called spin_lock two times consecutively without calling spin_unlock but my code didn't lock (I was managing an ioctl). 
Probably I didn't understand how spin_lock works!!!!

Any help?

       
---------------------------------
Need a vacation? Get great deals to amazing places on Yahoo! Travel. 
--0-1374990440-1188422775=:15506
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I discovered that I called spin_lock two times consecutively without calling spin_unlock but my code didn't lock (I was managing an ioctl). <br>Probably I didn't understand how spin_lock works!!!!<br><br>Any help?<br><p>&#32;
      <hr size=1>Need a vacation? <a href="http://us.rd.yahoo.com/evt=48256/*http://travel.yahoo.com/;_ylc=X3oDMTFhN2hucjlpBF9TAzk3NDA3NTg5BHBvcwM1BHNlYwNncm91cHMEc2xrA2VtYWlsLW5jbQ--">Get great deals 
to amazing places </a>on Yahoo! Travel. 
--0-1374990440-1188422775=:15506--
