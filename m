Subject: Task Queues
To: linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Date: Thu, 8 Jun 2000 14:23:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000608042335.85655415FA@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am trying to create an ISR for our hardware that implements a
"bottom half" interrupt handler. I use a task queue to do this
since our driver is a loadable module. Everything works fine
except that if the task is added to the tq_immediate task queue
it does not seem to run. If I use the tq_scheduler task queue
it works fine. I gather that for bottom halfves that it is
appropriate to schedule them on the immediate queue.

I have also tried running other tasks that are scheduled elsewhere
in the driver, and have the same problem.

Thanks

Greg.

--
+------------------------------------------------------+
| Do you want to know more? www.geocities.com/worfsom/ |
|              ..ooOO Greg Johnson OOoo..              |
| HW/SW Engineer        gjohnson@research.canon.com.au |
| Canon Information Systems Research Australia (CISRA) |
| 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
|      "I FLEXed my BISON and it went YACC!" - me.     |
+------------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
