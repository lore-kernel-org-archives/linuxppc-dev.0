Message-ID: <001c01be7482$0565a2f0$020210ac@paso.atasd.com>
From: "Brian Macy" <bmacy@sunshinecomputing.com>
To: <linuxppc-dev@lists.linuxppc.org>, <linuxppc-user@lists.linuxppc.org>
References: <19990321023338.A2592@persephone.ppc.kernel.org>
Subject: Success!!! Yeah!!!
Date: Mon, 22 Mar 1999 08:35:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Unfortunately I had to use R4 because I couldn't get preR5 to install after
many tries with all kind of variations. The only problem I had with R4 was
when I went into package selection and click on "base" (the last package) I
got a SEGV 11. I also had a bit of problem getting BootX Extension to
correctly pass the root device as an argument... it ended up as 00:00
several times until I actually booted into MacOS, changed the setting with
the BootX App, and saved the prefs. Shame I couldn't install preR5 on this
spare machine though.

Anyways, I noticed R4 is using kernel 2.1.125 which is nice. It means
modutils and a bunch of other packages are up to date for the 2.2.x series.
Are there any other packages I should update? Anyone try 2.2.3-ac4 yet (I
probably will this week)?

Brian Macy


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
