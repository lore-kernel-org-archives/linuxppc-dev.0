Date: 4 Jul 2002 17:07:53 -0000
Message-ID: <20020704170753.14420.qmail@webmail14.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	"Allen Curtis" <acurtis@onz.com>
Subject: bash prompt
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Denk,

         My  kernel serial driver for 8260 is able to give bash
prompt but its not able to read anything from serial console,bash
prompt is not at all responding

when i traced what i am seeing is

  when i attach the interrupts its gettting hanged all 8 leds are
glowing ,if temporarily if i  remove the interrupt handler there
is no problem of all 8 leds problem ,coming to bash prompt but not
responding

transmit_chars is happeneing proper but no receive_chars

is this the problem i am confused ,
let me know whre i am wrong
thanks in advance
somshekar

_________________________________________________________
There is always a better job for you at Monsterindia.com.
Go now http://monsterindia.rediff.com/jobs


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
