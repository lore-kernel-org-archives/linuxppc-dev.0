Message-ID: <3D599B06.836A002@rochcivictheatre.org>
Date: Tue, 13 Aug 2002 18:49:26 -0500
From: Tom Gall <tgall@rochcivictheatre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Anyone know what's up with the F50?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

  Just was trying to boot a _devel or _2_4 kernel on the F50 (4 way SMP)
the other day and no go. Didn't have a null serial cable for seeing what
the xmon output was but shall do that later this week. Anyway by the
looks of the LCD, we're dieing somewhere after start_kernel yet before
the console initialization code as prom_init is the last message on the
screen.
  IRQs were all directed to one CPU beyond that, pretty much a standard
CHRP config. Go figure.

  Regards,

  Tom
--
Regards,

Tom

--------------------------------------------------------------
Linux Guy             "My heart is human, my blood is boiling,
gall@rochcivictheatre.org    my brain IBM" -- Mr Roboto, Styxx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
