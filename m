Message-ID: <384D0835.74F85CEC@mitre.org>
Date: Tue, 07 Dec 1999 08:14:29 -0500
From: Frank McPherson <frank@mitre.org>
MIME-Version: 1.0
To: Claude Robitaille <crobitaille@videotron.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Debugging with thread(s)
References: <Pine.LNX.4.10.9912062143190.1956-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Claude Robitaille wrote:

> anybody has tried to debug an application that uses thread
> using GUI frontend to gdb? ... I execute pthread_create I get an
> unknown signal and the breakpoints I set in the called
> (created) thread do not activate. 

I get the same behavior when using gdb without any frontend.  Pthreads
seems to use real-time signals (32 and higher), and though the
documentation for gdb indicates it should be able to handle them, I
haven't been able to get it to work.  I posted a query about this
yesterday called "real-time signals, gdb".    

It has been suggested to me by another list member that the signal
handling code in the Linux kernel may be seriously deficient, and
aggrevating if not outright causing this problem.  I haven't had a
chance yet to look and see if that's the case. 

Has anyone else had success debugging threads with gdb? 

-Frank

-- 
Frank H. McPherson IV
W118 Embedded Solutions Team
The MITRE Corporation
703-883-5404

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
