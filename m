Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: asm inline
Date: Mon, 2 Dec 2002 09:37:56 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es> <200212020914.21465.kevin.hendricks@sympatico.ca> <jeisycebok.fsf@sykes.suse.de>
In-Reply-To: <jeisycebok.fsf@sykes.suse.de>
MIME-Version: 1.0
Message-Id: <200212020937.56585.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> |> Is there any warning flag that can be enabled to help find these
> |> cases (the OOo source base is simply huge)?
>
> gcc 3.3 implements such a warning, but it may give many false positives.

Any chance we can get this flag backported so that it appears in gcc 3.2.2?

False positives are a whole lot better than code that quietly does the an
unexpected thing.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
