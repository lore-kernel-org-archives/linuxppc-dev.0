Message-ID: <3CEE7017A3DBD611BF830060B01B7BAC09F8DA@SELTATOR>
From: Andreani Luca <landreani@seltatel.it>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: ppc and rtnetlink
Date: Fri, 25 Oct 2002 11:55:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear list,

I have a ppc 8245 based system (with hardat 2.1).
It must works as a router with two network interfaces.
In order to priorize some kinds of traffic I have to use tc (from iproute2)
It doesn't works and I see the message:

statistic truncated

I examined the tc source cod anf found out that this message refers to a
MACRO provided by rtnetlink.
Does anybody have ever seen this kind of message?
Do you know some problem using tc (and iproute) with ppc systems?

Thanks a lot.

Luca Andreani


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
