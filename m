From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David A. Gatwood" <dgatwood@apple.com>,
	"Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>,
	linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TiBook, 1394, iPod working (sort of  ;-)
Date: Tue, 27 Nov 2001 23:18:34 +0100
Message-Id: <20011127221834.23360@smtp.wanadoo.fr>
In-Reply-To: <B499780B-E362-11D5-9B27-003065B90BBC@apple.com>
References: <B499780B-E362-11D5-9B27-003065B90BBC@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> HFS+ Volumes are wrapped in a HFS-structure for security reasons, you
>> can
>> find out about his at some Website at Apple.
>
>Umm... last I checked, they were wrapped in an "almost" HFS structure so
>that older machines whose { firmware, ROMs } didn't support HFS+ could
>still boot from them....  Did I miss something?  :-)

No, you didn't ;) In fact, I even think recent MacOS (or is it MacOS X ?)
may create pure HFS+ volumes without the wrapper.

The main reason for the wrapper was for machines running non-HFS+ capable
filesystem to display something (where are all my files gone ?) instead
of proposing you to format the disk, and for the system to be able to
boot from HFS+ since OldWorld ROMs didn't understand it. Basically, the
wrapper contains a slim-fast MacOS System file which contains the necessary
HFS+ support to mount the real volume and continue booting from that.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
