Date: Wed, 1 Dec 1999 17:32:39 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Compiler Problem?
In-Reply-To: <384548C4.1E9ADDAF@muenchen.europe.mcd.mot.com>
Message-ID: <Pine.HPX.4.10.9912011724060.10294-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 1 Dec 1999, Alois Fertl wrote:

> 
> Given the following lines of C, I'd expect that the 4th argument
> is placed into register 6 and 7. As the assembler listing tells,
> register 6 is omitted and the argument goes into r7/r8.

No, that's normal but it has been fluctuating and I clearly remember a
version of gcc in which the caller and the callee did not agree in this
case...

The standard now is that 8 byte int parameters are "naturally" aligned
(for example when stored in a vararg list) which imposes occasional
skipping of a register (and makes the alignment requirement
counterintuitive since the first parameter register has an odd number)...

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
