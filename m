Message-ID: <82867A41A066D111B80D00A0C90815E93FB419@WATSON>
From: Will Wood <wwood@borealiscorp.com>
To: "'kbhend@business.wm.edu'" <kbhend@business.wm.edu>, gdt@linuxppc.org,
        sbb@gnu.org, linuxppc-dev@lists.linuxppc.org, egcs@egcs.cygnus.com
Subject: RE: Problem with egcs and denormalized constants?
Date: Thu, 4 Mar 1999 10:43:22 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My LinuxPPC configuration is currently down but here's some results from
HP and Solaris.  All are
running EGCS-1.1.1

HPUX 10.20 EGCS 1.1.1 HP 9816

flmin(0) is  1.4023984275674e-37
flmin(1) is  1.4023983434895e-38
flmin(2) is  1.4023984836193e-39
flmin(3) is  1.4023914771270e-40
flmin(4) is  1.4024195030963e-41
flmin(5) is  1.4026997627891e-42
flmin(6) is  1.4012984643248e-43
flmin(7) is  1.4012984643248e-44
flmin(8) is  1.4012984643248e-45
But flmin(7)/10.0F is  1.4012984643248e-45

UltraSparc II/256 Solaris 2.6 EGCS-1.1.1

flmin(0) is  1.4023984275674e-37
flmin(1) is  1.4023983434895e-38
flmin(2) is  1.4023984836193e-39
flmin(3) is  1.4023914771270e-40
flmin(4) is  1.4024195030963e-41
flmin(5) is  1.4026997627891e-42
flmin(6) is  1.4012984643248e-43
flmin(7) is  1.4012984643248e-44
flmin(8) is  1.4012984643248e-45
But flmin(7)/10.0F is  1.4012984643248e-45

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
