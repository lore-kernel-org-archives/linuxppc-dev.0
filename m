Date: Thu, 14 Mar 2002 06:44:28 -0800 (PST)
From: Adam Wozniak <awozniak@comdev.cc>
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problems with shared memory
In-Reply-To: <3C88C54E.7040402@bluewin.ch>
Message-ID: <Pine.LNX.4.33.0203140639320.21307-100000@rangers.comdev.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 8 Mar 2002, Wolfgang Grandegger wrote:
>  Adam Wozniak wrote:
> >Thanks so much.  I think that fixed it.  10000+ iterations without problem.
> The real thank goes to David who found it.
>
> Well, for me the linuxppc_2_4 tree seems to be less up-to-date. It would
> be nice if somebody could give a brief status or even recommandation
> on the various trees (linuxppc_2_4, linuxppc_2_4_devel, linuxppc_2_5)
> including their future ... or point me to a list where it's already
> dicussed.

I may have spoken too soon.  That fixed this particular problem, but I've
got engineers in the field who still see the bad behavior, albeit far less
frequently.  Are there any other bugfixes for the linuxppc_2_4 kernel mm
out there?

I've tried looking at the linuxppc_2_4_devel tree for changes, but there
seem to be a lot for the mm, and these changes ripple out to other parts
of the code; I can't just grab a file here and there, the changes start
to be too much.

--Adam
--
Adam Wozniak (KG6GZR)   COM DEV Broadband - Digital and Software Systems
awozniak@comdev.cc      805 Aerovista Place, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
