Return-Path: <skrishnakar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <fa686aa40905242339l51ee5656ue388cde6da253287@mail.gmail.com>
References: <6213bc560905190608j73f4191fxbd94158a2b1740c0@mail.gmail.com>
	<20090519235302.GA6333@yookeroo.seuss>
	<6213bc560905192250w4caa84aem9c0dedb2eed72fea@mail.gmail.com>
	<6213bc560905242330j31c14d22pabb67174e105d68c@mail.gmail.com>
	<fa686aa40905242339l51ee5656ue388cde6da253287@mail.gmail.com>
Date: Mon, 25 May 2009 12:21:06 +0530
Message-ID: <6213bc560905242351r7682dcb2m898beef8b334e010@mail.gmail.com>
Subject: Re: Initialize DBCR0 for PPC440 targets
From: srikanth krishnakar <skrishnakar@gmail.com>
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi John,

I am not finding any conclusion of the plan to add DBCR0
initialization code to head_44x.S after this discussion :

http://www.nabble.com/Question-about-DBCR0-initialization-for-440-td2304904=
4.html#a23049044

Can you please comment ?

Thanks,
-Srikanth Krishnakar

On Mon, May 25, 2009 at 12:09 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Mon, May 25, 2009 at 12:30 AM, srikanth krishnakar
> <skrishnakar@gmail.com> wrote:
>> Hello Grant,
>>
>> Is there any conclusion of the below discussion:
>>
>> http://www.nabble.com/Question-about-DBCR0-initialization-for-440-td2304=
9044.html
>>
>> Xilinx target (virtex5) hangs (while running GDBServer & KGDB) without
>> the DBCR0 initialization.
>>
>> Can you please comment on this ?
>
> IIRC, John Linn was hacking on a patch. =A0Search the mailing list
> archives for DBCR0.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************
