Date: Thu, 22 Nov 2001 14:19:57 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: scop@digitel.com.br
Message-ID: <8597.011122@digitel.com.br>
To: Wolfgang Denk <wd@denx.de>
Cc: "Sarnath Kannan" <sparc64@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: DINK - the downloader !
In-reply-To: <20011122131718.999A6F9BA@denx.denx.de>
References: <20011122131718.999A6F9BA@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello guys,

Thursday, November 22, 2001, 10:17:13 AM, you wrote:

WD> Dear Sarnath,

WD> in message <20011122122132.18969.qmail@mailweb26.rediffmail.com> you wrote:
>>
[snip]
>> via ethernet card. Any such utilities for the
>> sandpoint platform are available.. ?

WD> Use PPCBoot.

I second this :-)

WD> I'm not sure how good the Sandpoint support is  at  the  moment,  but
WD> it's  there,  and  it compiles, and some people say they actually use
WD> it.

>>  Whats "tftp" and How do I set it up ?

I think this is a fair question. When I bought my Abatron BDI2000, I
had a hard time setting up a TFTP server on my Linux host... it was
much easier to use the Windowze-based TFTP server that came along
with the Abatron firmware :-(

Fortunatelly, we have some local Linux gurus here at my job place. So,
basically, what has to be done, assuming a Linux host, is:

1 - Check if you're lucky: try locating in.tftpd in your bin
directories (mainly in /usr/sbin)

2 - If you don't have it, download it from the web; better download
both server and clients apps

3 - Install them (I have a Red Hat box, so installing rpm's is
straightforward for me :-)

4 - Now, the tough part: you'll have to manually configure inetd (or
worse, xinetd - depending on your system). I can put a copy of a
sample conf file here, if you need it...

HTH,

Ricardo Scop                            mailto:scop@digitel.com.br
R SCOP Consulting

------------------------------------------------------------------
"What's money? A man is a success if he gets up in the morning and
goes to bed at night and in between does what he wants to do."
~Bob Dylan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
