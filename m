Date: Fri, 25 Apr 2003 17:34:22 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: _PAGE_HWWRITE missing in pte_mkdirty()?
In-reply-to: <3EA94CB4.8050509@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEEJFMAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I noticed that pte_mkdirty() does not set the change bit(HWWRITE) when
> > dirtying a page. I think it should. Is there a reason why it doesn't?
>
> A dirty page doesn't necessarily indicate a write enabled page.  Setting
> _PAGE_HWWRITE without _PAGE_RW is an error.  On PPC, RW and DIRTY are
> software status bits, HWWRITE actually contols write access.

OK, I wasn't aware that you can have dirty pages without _PAGE_RW.

   Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
