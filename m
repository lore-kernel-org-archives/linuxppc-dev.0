Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F6D1B@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Minilibc works better than Library Optimizer
Date: Fri, 19 Apr 2002 07:57:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Murali,

The objetive of minilibc is to reduce libc, but changing the makefile who
rebuilds libc probably works with other librarys. I don't probe with other
librarys, I recomend you to try it.

By.

	-----Mensaje original-----
	De:	murali venkateshaiah [SMTP:mvenkat_ml@yahoo.com]
	Enviado el:	jueves, 18 de abril de 2002 20:15
	Para:	IGOR LURI
	Asunto:	Re: Minilibc works better than Library Optimizer

	hi Igor

	What about optimizing other libraries (other than
	glib)...I beleive minilibc is libc specific isnt it?

	-Murali

	--- IGOR LURI <iluri@fagorautomation.es> wrote:
	>
	> Hi all,
	> I have waste a lot of time with Library Optimizer
	> and I dont have succes
	> with it. The glibc optimized with this tool doesn't
	> work to me. However, I
	> have found another tool named MINILIBC that works
	> fine. This tool can be
	> downloaded from
	>
	>

http://oss.software.ibm.com/developer/opensource/linux/projects/minilibc/rel
	> eases/
	>
	>  I have proobed with glibc-2.2.3 and works fine, I
	> recomend to use this tool
	> instead of library optimizer.
	>
	> By.
	>
	> ** Sent via the linuxppc-embedded mail list. See
	> http://lists.linuxppc.org/
	>


	__________________________________________________
	Do You Yahoo!?
	Yahoo! Tax Center - online filing with TurboTax
	http://taxes.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
