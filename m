Message-ID: <40487EC0.9070501@jonmasters.org>
Date: Fri, 05 Mar 2004 13:21:04 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: uncached user space mapping with mmap() ???
References: <40473464.8010203@imc-berlin.de> <404837D3.3060609@imc-berlin.de> <40486600.9090304@jonmasters.org> <40486783.7010703@imc-berlin.de>
In-Reply-To: <40486783.7010703@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Steven Scholz wrote:

| Yes. The thruput is calculated after repeating the loop 1000 times
| (Retries = 1000).

That is not an accurate measurement though because you really need to
repeat this a few times on the host from a cold start under similar
conditions for people to actually see much difference in these figures -
within a single run you might well see a small delta between the two.

|> You will need to answer the questions Russell King posted in order for
|> us to work through this and figure out where the difference lies.

| I am just about to do it.

Ok.

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
