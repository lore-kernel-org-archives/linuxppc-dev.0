Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Message-Id: <v04204e0eb35f112116ec@[206.163.71.146]>
In-Reply-To: <373926B4.6BFD7CE7@loomer.com>
References: <373926B4.6BFD7CE7@loomer.com>
Date: Wed, 12 May 1999 04:47:18 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Joel Klecker <jk@espy.org>
Subject: Re: Does Linux PPC support the new 'Lombard/101' Powerbook G3s?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 23:59 -0700 1999-05-11, Hugh Caley wrote:
>Why do you think it would work, Tom?  You can't OF boot the "Wallstreet"
>G3 laptops, can you?

<http://developer.apple.com/techpubs/hardware/Developer_Notes/Macintos 
h_CPUs-G3/PowerBookG3Series_1999/index.html> shows the new powerbooks 
to be of the new world architecture, thus it has sane OF (though 
until we have ELF images that the OF likes, no OF booting).

On a unsupported hardware note: the ethernet controller is a DP83843 
PHYTER made by National Semiconductor, which will need a driver 
written for it.
Docs: <http://www.national.com/pf/DP/DP83843.html>.

-- 
Joel Klecker (aka Espy)                    Debian GNU/Linux Developer
<URL:mailto:jk@espy.org>                 <URL:mailto:espy@debian.org>
<URL:http://web.espy.org/>               <URL:http://www.debian.org/>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
