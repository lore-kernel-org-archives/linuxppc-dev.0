Message-ID: <3C9F6EF8.2070504@embeddededge.com>
Date: Mon, 25 Mar 2002 13:39:52 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Neil Horman <nhorman@lvl7.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: another question.....
References: <3C9E2C99.AE0E60B@lvl7.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Horman wrote:

> 	I also had a question regarding the swapper_pg_dir variable.

It's used to represent the kernel mapping.  The combination of the
kernel mapping and that of the current application memory context will
determine how memory is accessed.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
