Message-ID: <67505026E29DD311A9AA00508B7315F31956C2@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: is caching required with ram disk
Date: Thu, 24 Aug 2000 14:24:48 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Thank you to John for telling me what to comment out in vmscan.c The while
swap_out is gone and my ram disk is 100 times happier.

My new question is
Do I need caching on at all when I am using ram disk? I would for go the
performance rather than using 3 megs of ram to do caching. How would I turn
cahing off?

Thanks in advance,
--Julia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
