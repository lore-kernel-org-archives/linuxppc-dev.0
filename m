Message-Id: <378DE082.B1679C71@duettech.com>
Date: Thu, 15 Jul 1999 18:52:10 +0530
From: Rajendra Prasad <prasadr@duettech.com>
Mime-Version: 1.0
To: linux-ppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: help on lost interrupt
Content-Type: multipart/mixed;
 boundary="------------7A420AC6239D4D1166E3AB7A"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------7A420AC6239D4D1166E3AB7A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I was looking the source code of linux for ppc. In the interrupt
handling
there is a concept of lost_interrupt and do_lost_interrupt. I could not
understand why this is required and how it is managed on linux.

Is it something like interrupt is recognized by isr but not serviced by
the 
drivers and interrupt is left as disabled?

regards
Rajendra Prasad
--------------7A420AC6239D4D1166E3AB7A
Content-Type: text/x-vcard; charset=us-ascii;
 name="prasadr.vcf"
Content-Description: Card for Rajendra Prasad
Content-Disposition: attachment;
 filename="prasadr.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard 
n:Prasad;Rajendra
tel;home:91-118-535666
tel;work:91-118-567001
x-mozilla-html:FALSE
url:www.duettech.com
org:Duet Technologies Ltd.;Telecom
adr:;;#B1,  SDF, NEPZ;NOIDA;U.P.;201305;INDIA
version:2.1
email;internet:prasadr@duettech.com
title:Project Leader
x-mozilla-cpt:;-14352
fn:Rajendra Prasad
end:vcard

--------------7A420AC6239D4D1166E3AB7A--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
