Date: Thu, 21 Feb 2002 11:44:04 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: scop@vanet.com.br
Message-ID: <18488.020221@vanet.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Fwd: Re[2]: Question about the dcache of ppcboot??
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Goddeeris,

Yes, this is completely true (tm) with CPU's that have internal memory
like 82xx and 8xx families, as Wolfgang Denk have already pointed out
in message

http://www.geocrawler.com/archives/3/4205/2002/1/0/7645212/


R. Scop                            mailto:scop@vanet.com.br

------------------------------------------------------------------
"Everything has beauty, but not everyone sees it." ~Confucius

Thursday, February 21, 2002, 4:31:14 AM, you wrote:


GF> Hi,

GF> I think I have seen discussions on the ppcboot-users mailing list
GF> mentioning that it is normal that ppcboot crashes when you switch dcache on
GF> (icache should work)

GF> Fred

GF> -----Original Message-----
GF> From: ???
GF> To: linuxppc-embedded@lists.linuxppc.org
GF> Sent: 2/21/02 6:33 AM
GF> Subject: Question about the dcache of ppcboot??


GF> Hello.
GF> Greetings from korea.
GF> My name is jaechol, and I'm a newbie.
GF> Please excuse my English.

GF> I ported ppcboot-1.1.4 to my custom board with mpc862 cpu.
GF> Everything is OK, except of dcache.
GF> Icache works fine. but dcache don't work
GF> Atfer issuing dcache on,  my custom board hangs.
GF> Is there a need that I do for dcache on??

GF> my board:
GF>                 cpu mpc862
GF>                 2MByte Boot-flash on CS0
GF>                 SDRAM on CS2

GF> ========================================================================
GF> ======
GF> ?? ???, Daum http://www.daum.net
GF> - Daum??? ?? ????? + ?? ???? ? http://hmm.daum.net/shop_0202
GF> - 100% ?? ??! Daum?? ???? ? http://hmm.daum.net/keyword_top_0202


GF> ** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/


===8<===========End of original message text===========


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
