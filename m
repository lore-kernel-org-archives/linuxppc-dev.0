Date: Thu, 27 Nov 2003 17:07:25 +0100 (MET)
From: Juergen Oberhofer <e9826367@student.tuwien.ac.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mpc / linux kernel - user space
Message-ID: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a module and an application program in user space:

The Module performs the following task: at init it initializes the cpm
timer register of the mpc823,
such that an interrupt is generated every x microseconds. Thus, I
installed an interrupt handling function f that handles the timer
interrupts.

My problem is that the module / the interrupt handling function should
execute a procedure defined in the application program. How can I pass a
pointer (which points to that function) from the appl.program to the
module, such that the handler can execute this function every x
milliseconds? I thought to create a procedure in the module that accepts
a function pointer as argument. But how can I achieve, that this module
procedure is visible to the application program? Does somebody have a
suggestion or know another way to do it?

Regards,
Juergen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
