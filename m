Date: 30 Jul 2002 05:54:32 -0000
Message-ID: <20020730055432.14414.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
From: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
Reply-To: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: error in printf
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everybody,
i am trying to download the ELf image compiled on linux using a
cross compiler for powerpc on to SDS simulator..
the error that it is giving is
"aborting due to failure of ELF reader"
after changing some unknown numbers(0000000000,137777777) in the
.elf file the error goes...
but the real problem is that
i have linked the printf function dynamically(thats done by
default)..
so the code of the printf is not seen while i try to debug it in
the SDS debugger.
it shows illegal instruction at the point where printf's code shld
occur..
shld i use static library instead..
it would really be nice if u could solve my problem.
thanks in advance
regards
vandana


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
