To: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Joao Vicente" <joao.vicente@spectel.com>
Subject: Re: relocate code 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "11 Oct 2003 07:13:22 -0000."
             <20031011071322.23815.qmail@webmail28.rediffmail.com>
Date: Sat, 11 Oct 2003 16:32:28 +0200
Message-Id: <20031011143233.925CBC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031011071322.23815.qmail@webmail28.rediffmail.com> you wrote:
>
>
> --Next_1065856402---0-203.199.83.38-23744
> Content-type: text/html;
> 	charset=iso-8859-1
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline

Arghhh.... Please don't post HTML to the  mailing  list.  Send  plain
text only.

>  I have ppcboot-2.0.0 working on 8mb SDRAM ,
> now i have moved to same type of board with 32mb SDRAM , with U-boot,

You are off topic here. You should rather ask questions like this  on
the U-Boot-users mailing list.

> my code gets hanged in relocate code , sdram pattern i swritten properly, and intilaized ,

> ANY ideas please suggest , i dont get whats going wrong

Your SDRAM initialization is broken.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If in any problem you find yourself doing an immense amount of  work,
the answer can be obtained by simple inspection.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
