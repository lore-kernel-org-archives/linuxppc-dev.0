Subject: Re: why so slowly when use serial to download S-record file?
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: caixupeng <edmoon@huawei.com>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <001701c292aa$b061a4c0$33690b0a@DBKQW41X>
References: <001701c292aa$b061a4c0$33690b0a@DBKQW41X>
Content-Type: text/plain
Date: 25 Nov 2002 09:56:05 +0100
Message-Id: <1038214565.542.27.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The reason is that ppcboot/u-boot only support a very simple version of
kermit where the sender waits for an ack before sending another block.

kermit should have a mode that is as efficient as some of the
[x|y|z]-modem maybe you could add that code to u-boot.

On Sat, 2002-11-23 at 05:42, caixupeng wrote:
>
> Dear all,
>
> my ppcboot is 1.2.1
> and I set baud rate to 38400, but it need almost 4 hours to download a 2 Mega bytes file.
> what's wrong ?
>
> my board is ebony.
>
> Who know the reason?
>
> please tell me.
>
> thanks!
>
> edmoon
>
>
--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
