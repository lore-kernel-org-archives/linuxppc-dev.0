Subject: Re: status of fec
To: jelbert@enerdyne.com (Julia Elbert)
Date: Fri, 6 Oct 2000 12:57:45 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
In-Reply-To: <67505026E29DD311A9AA00508B7315F350A552@EXCHANGE> from "Julia Elbert" at Oct 05, 2000 11:33:02 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20001006015745.3CFDC219@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert writes:
> Does anyone know the current status of the fec with 2.2.14?

Well, the one in the HardHat-1.2 kernel based on 2.2.14 works for us.  The
only changes we made to it were:

- Add support for the LXT971/2 PHY (only if your board needs it):
    http://lists.linuxppc.org/listarcs/linuxppc-embedded/200005/msg00036.html

- Minor (15% - 20%) performance improvement by eliminating a copy, and a few
  packet stats bug fixes (I recommend it):
    http://members.nbci.com/greyhams/linux/patches/2.2/fecdmaskb.patch

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
